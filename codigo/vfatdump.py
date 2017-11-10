#!/usr/bin/python
# *-* Encoding: UTF-8 *-*

# $ /sbin/mkfs.fat -D 0x00 -v  /tmp/fat12.img 
# mkfs.fat 3.0.28 (2015-05-16)
# /tmp/fat12.img has 2 heads and 9 sectors per track,
# hidden sectors 0x0000;
# logical sector size is 512,
# using 0xfd media descriptor, with 720 sectors;
# drive number 0x00;
# filesystem has 2 12-bit FATs and 2 sectors per cluster.
# FAT size is 2 sectors, and provides 354 clusters.
# There is 1 reserved sector.
# Root directory contains 112 slots and uses 7 sectors.
# Volume ID is 2b7978f4, no volume label.
# $ su
# # mount fat12.img /mnt/ -t msdos -o fat=12 -o loop
# # echo "Un primer archivo" > /mnt/UnPrimerArchivo
# # echo '@echo off' > /mnt/AUTOEXEC.BAT
# # umount /mnt
# # exit
#
# Referencia para las posiciones de valores que empleo:
#
# https://www.win.tue.nl/~aeb/linux/fs/fat/fat-1.html

import mmap
import warnings

# Convierte cadenas de texto en valores numéricos. Expone únicamente
# un método estático, StrConv.int(str)
class StrConv:
    def __init__(self):
        pass
    @staticmethod
    def int(str):
        accum = 0
        for byte in reversed(range(len(str))):
            accum += ord(str[byte])
            if byte != 0:
                accum *= 256
        return accum

# Representa la estructura general de un sistema de archivos FAT
class FatFS:
    # Inicialización: Abre el archivo en el que reside el sistema de
    # archivos a trabajar, mapeándolo íntegro a memoria, y parsea y
    # realiza la revisión de sus principales estructuras
    def __init__(self, filename):
        self.fd = open(filename, 'r+')
        mm = mmap.mmap(self.fd.fileno(), 0)
        self.mm = mm

        # Sector 1: The boot sector. Get the operating parameters.
        self.__parse_boot_sector()

        # Next comes the FAT. We just sanity-check it, but don't yet
        # process anything there.
        self.__init_ck_fat()
        self.fat = FAT(self.fstype, mm[self.fat1_start:self.fat1_end])

        self.directory = Directory(mm[self.dir_start:self.dir_end], self.fat)

    # Imprime información general del sistema
    def info(self):
        return """=== FAT Filesystem ===
        Filesystem type     : %s
        Label               : %s
        Bytes per sector    : %d
        Sectors per cluster : %d
        Number of FATs      : %d
        Max dir entries     : %d
        Total sectors       : %d
        Media descriptor    : 0x%x
        Sectors per FAT     : %d
        Sectors per track   : %d
        Heads               : %d
        Hidden sectors      : %d

        FAT 1 starts at 0x%x, ends at 0x%x
        FAT 2 starts at 0x%x, ends at 0x%x
        Directory starts at 0x%x, ends at 0x%x
        Data space starts at 0x%x
        """ % (self.fstype, self.label, self.bytes_x_sect, self.sect_x_clust,
               self.num_fats, self.num_dentries, self.total_sect,
               self.media_descr, self.fat_sect, self.sect_x_track,
               self.heads, self.hidden_sect, self.fat1_start,
               self.fat1_end, self.fat2_start, self.fat2_end,
               self.dir_start, self.dir_end, self.data_start)

    # Parsea el sector de arranque: Tomando las ubicaciones absolutas
    # documentadas de las estructuras que conforman al sector de
    # arranque de un volumen FAT, las carga al objeto en memoria y
    # prepara el terreno para comenzar a obtener los datos
    def __parse_boot_sector(self):
        mm = self.mm

        self.fstype       = mm[54:59]
        if ((self.fstype != 'FAT12' and self.fstype != 'FAT16') or
            mm[510:512] != '\x55\xaa'):
            raise Exception('Expected a FAT12/FAT16 volume!')

        self.bytes_x_sect = StrConv.int(mm[11:13])
        self.sect_x_clust = StrConv.int(mm[13])
        self.num_fats     = StrConv.int(mm[16])
        self.num_dentries = StrConv.int(mm[17:19])
        self.total_sect   = StrConv.int(mm[19:21])
        self.media_descr  = StrConv.int(mm[21])
        self.fat_sect     = StrConv.int(mm[22:24])
        self.sect_x_track = StrConv.int(mm[24:26])
        self.heads        = StrConv.int(mm[26:28])
        self.hidden_sect  = StrConv.int(mm[28:30])
        self.label        = mm[43:53]

        fatlen = self.bytes_x_sect * self.fat_sect
        self.fat1_start = self.bytes_x_sect
        self.fat1_end   = self.fat1_start + fatlen

        self.fat2_start = self.fat1_end
        self.fat2_end   = self.fat2_start + fatlen

        self.dir_start = self.fat2_end
        self.dir_end = self.dir_start + self.num_dentries * Dentry.size()

        self.data_start = self.dir_end

    # Verificación trivial de sanidad en las dos copias del FAT en el
    # sistema de archivos
    def __init_ck_fat(self):
        base = self.bytes_x_sect
        fatlen = self.bytes_x_sect * self.fat_sect
        fat1 = self.mm[base:base+fatlen]
        fat2 = self.mm[base+fatlen:base+fatlen+fatlen]
        if ord(fat1[0]) != self.media_descr:
            warnings.warn("Media description wrong. Possible volume corruption.")
            warnings.warn("Should be: 0x%x; got: 0x%x" % (self.media_descr, ord(fat1[0])))
        if fat1 != fat2:
            warnings.warn("FAT tables are not identical. Possible volume corruption.")

class FAT:
    VERSIONS = ['FAT12', 'FAT16']
    def __init__(self, version, data):
        self.data = data
        if version in self.VERSIONS:
            self.version = version
        else:
            raise Exception, 'FAT version %s not supported (can handle: %s)' % (version, VERSIONS)

        # The first entry only repeats the filesystem's media_descr,
        # padding with 'ff'. It gets validated at FatFS
        # initialization, we just ignore it. The second entry is the
        # 'end of chain' marker — take note of it!
        if self.version == 'FAT12':
            # Usually, 2^12-2=4093 (0xffd)
            self.end_of_chain = StrConv.int(self.data[1:3]) % 2**12
        elif self.version == 'FAT16':
            # Usually, 2^16-2=65535 (0xfffd)
            self.end_of_chain = StrConv.int(self.data[2:4])

    def is_empty(self, cluster):
        if self.__value_for_cluster(cluster) == 0:
            return True
        return False

    def is_final(self, cluster):
        if self.__value_for_cluster(cluster) == self.end_of_chain:
            return True
        return False

    def cluster_string(self, cluster):
        string = []
        if self.is_empty(cluster):
            return []

        while not self.is_final(cluster):
            string.append(cluster)
            cluster = self.__value_for_cluster(cluster)
        return string

    def __value_for_cluster(self, cluster):
        if isinstance(cluster, str):
            cluster = StrConv.int(cluster)
        res = None
        if cluster == 0 or cluster == 1:
            raise Exception, 'Illegal cluster requested'
        if self.version == 'FAT16':
            start = cluster*2
            end = start+2
            res = StrConv.int(self.data[start:end])
        elif self.version == 'FAT12':
            # With a 12-bit alignment, we have to operate on a
            # sub-byte boundary :-/
            start = cluster * 1.5
            end = (cluster + 2) * 1.5
            if start % 1 == 0:
                res = StrConv.int(self.data[start:start+2]) >> 4
            else:
                res = StrConv.int(self.data[start:start+2]) & 4095
        return res


# Representación de un directorio completo. Ha sido únicamente probado
# con el directorio raiz, pero en teoría debería funcionar con
# subdirectorios también.
class Directory:
    def __init__(self, data, fat):
        size = Dentry.size()
        self.dentries = []
        self.fat = fat
        num_dentries = len(data) / size

        for entry in range(num_dentries):
            start = entry * size
            end = start + size
            self.dentries.append( Dentry( data[start:end] ))

    def verbose(self):
        return "\n".join(filter(None, map((lambda d: d.dir_info()), self.dentries)))

    def filenames(self):
        return filter(None, map((lambda d: d.name), self.dentries))

    def entries(self):
        return filter((lambda d: d.name), self.dentries)

    # def fat_chain(self, entry):
    #     return self.fat.cluster_string(entry.cluster_string)


# Cada una de las entradas del directorio (Directory Entries). No
# procesa todos los metadatos del directorio, sólo aquellos que hemos
# requerido. No soporta a VFAT, ignora todos los atributos que éste
# permite.
class Dentry:
    SIZE = 32
    def __init__(self, string):
        self.name = None
        self.ext = None
        self.size = None
        self.start_at = None

        if string[0:32] == chr(0) * 32:
            # Entrada vacía
            self.what = 'Empty'
        elif string[11] == chr(0x0f):
            # Nombre largo VFAT - Ignorar
            self.what = 'VFAT'
        elif string[11] == chr(0x20) or string[11] == chr(0x10):
            # Entrada base FAT
            self.name = string[0:8]
            self.ext = string[8:11]
            if string[11] == chr(0x20):
                self.what = 'File'
            else:
                self.what = 'Directory'
            self.start_at = StrConv.int(string[26:27])
            self.size = StrConv.int(string[28:31])

    def dir_info(self):
        if self.name == None or self.what == 'Empty':
            return None
        return '%5s %8s.%3s: %8db from 0x%03x' % (self.what, self.name, self.ext, self.size, self.start_at)

    @classmethod
    def size(cls):
        return cls.SIZE


if __name__ == '__main__':
    import sys
    if len(sys.argv) == 2:
        filename = sys.argv[1]
    else:
        filename = '/tmp/fat12.img'
    fs = FatFS(filename)
    print fs.info()
    # for i in fs.directory.entries():
    #     print fs.directory.fat_chain(i.start_at)
    print fs.directory.verbose()

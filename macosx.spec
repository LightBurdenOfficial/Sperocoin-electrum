# -*- mode: python -*-
a = Analysis(['sperocoin-electrum'])

##### include folder in distribution #######
def extra_data(folder):
    def rec_glob(p, files):
        import os
        import glob
        for d in glob.glob(p):
            if os.path.isfile(d):
                files.append(d)
            rec_glob("%s/*" % d, files)
    files = []
    rec_glob("%s/*" % folder, files)
    extra_data = []
    for f in files:
        extra_data.append((f, f, 'DATA'))

    return extra_data
###########################################

# Theme data
a.datas += extra_data('data')

# Localization
#a.datas += extra_data('locale')

pyz = PYZ(a.pure)
exe = EXE(pyz,
          a.scripts,
          exclude_binaries=True,
          name='Sperocoin Electrum',
          debug=False,
          strip=None,
          upx=True,
          console=False , icon='electrum.icns')
coll = COLLECT(exe,
               a.binaries,
               a.zipfiles,
               a.datas,
               strip=None,
               upx=True,
               name='Sperocoin Electrum')
app = BUNDLE(coll,
             name='Sperocoin Electrum.app',
             icon='electrum.icns')

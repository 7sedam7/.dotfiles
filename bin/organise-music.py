import os
import shutil
from mutagen.flac import FLAC

for file in os.listdir('.'):
    if file in ['mise.toml', 'organise.py', '.DS_Store']:
        continue
    audio = FLAC(file)
    path = f'../../{audio['artist'][0]}/{audio['album'][0]}'
    print(f'Creating dir for: {file}')
    os.makedirs(path, exist_ok=True)
    print(f'Moving dir: {file}')
    shutil.move(file, f'{path}/{str(audio['tracknumber'][0])} - {audio['title'][0].replace('/', '-')}.flac')

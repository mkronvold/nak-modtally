[ $(which pip) ] || sudo apt install python3-pip
cd ~/src/nak-modtally/
[ -d ~/nak-modtally/WorkshopManager ] || git clone git@github.com:mkronvold/WorkshopManager.git
cd ~/src/nak-modtally/WorkshopManager/
pip install -r requirements.txt
python wm.py set login mkronvold 's!Blowfish20'
python wm.py set appid 107410
mkdir mods
python wm.py set install_dir ./mods
python wm.py search Nak

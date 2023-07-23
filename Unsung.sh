./modparse.sh https://steamcommunity.com/sharedfiles/filedetails/?id=3006511687 Nak_Unsung_Req
./modparse.sh https://steamcommunity.com/sharedfiles/filedetails/?id=3006516384 Nak_Unsung_Opt
git st
git add -A
git commit -m "Unsung"
git push
cp PRESETS/Nak_Unsung_Req.html /mnt/p/FilePile/ArmA3/
cp PRESETS/Nak_Unsung_Opt.html /mnt/p/FilePile/ArmA3/

pushd /mnt/p/FilePile/ArmA3
git st
git add -A
git commit -m "Unsung"
git push
popd

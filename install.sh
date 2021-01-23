#!/bin/bash
sudo apt-get update
sudo apt-get install pv cgpt gnome-disk-utility

gnome-disks

zenity --entry --cancel-label="İptal Et" --ok-label="Devam Et" \
--title="ChromeOS Yükleyici" --width="360" --height="120" \
--text="ChromeOS u hangi bölüme kurmak istiyorsunuz?"
BOLUM="$?"

zenity --question --cancel-label="İptal Et" --ok-label="Devam Et" --title="ChromeOS Yükleyici" \
          --width="360" --height="120" --window-icon="warning" --icon-name="gtk-dialog-warning" \
          --text="Devam et tuşuna bastığınızda ChromeOS cihazınıza yüklenecektir. \n\nBu işlem seçili bölümdeki tüm verileri sileceğinden (İşletim sistemi dahil) önemli verilerinizi yedeklemenizi öneririz. Devam etmek istiyor musunuz?" 2>/dev/null
if [[ "$?" != "0" ]]; then ${opt_procedure[@]}
else
	sleep 5 | echo "İşlem 5 saniye içerisinde başlayacaktır. İptal etmek için Terminali HEMEN ŞİMDİ KAPATIN!"
	sudo bash chromeos-install.sh -src chromeos.bin -dst $BOLUM | zenity --progress \
		--title="ChromeOS Yükleyici" \
		--text="ChromeOS yükleniyor... İşlem tamamlana kadar terminali, bu pencereyi ve bilgisayarı kapatmayın!" \
		--percentage=0 \
		--width 400 \
		--pulsate \
		--auto-close 
		zenity --info --width="400" --text="ChromeOS kuruldu. Keyfini çıkarın!"
fi

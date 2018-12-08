#!/system/xbin/bash
# gihtub : https://github.com/afelfgie

R='\x1b[1;31m'
G='\x1b[1;32m'
B='\x1b[1;34m'
Y='\x1b[1;33m'
C='\x1b[1;36m'
D='\x1b[0m'

function Percent(){
    message="$1" #$1 artinya untuk memasukan data ke parameter ke 1
    max=$2 #$2 untuk parameter ke 2 dan seterusnya


    #make loop
    while true; do
        i=0
        # -le (less than) atau kurang dari
        # 0 kurang dari max (100)
        # maka pernyataan di jalankan berupa tulisan 1-100
        while [ $i -le $max ]; do
            echo -ne "\r${G}[+]${D} $message ${C}$i${D} %"
            sleep 0.1
            # jika i nilainya sama dengan 100 atau batas max maka metode / fungsi Percent di jalankan lagi
            # Percent "Loading..." 100
            # akan terus di ulang
            if [ $i -eq 100 ]; then
                echo -ne "${C} [complete!]${D}\n"
                Percent "Loading..." 100
            fi
            # naikan nilai variabel i sebesar 1
            # ini yang akan membuat tulisan angka 1 sampai 100
            let i++
        done
    done
}
Percent "Loading..." 100

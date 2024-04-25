@echo off
CHCP 65001

    cd /d c:\garden-affairs

    echo pushing
    git push
   
    IF ERRORLEVEL 1 (
      echo pushed fail, need pull
      git pull -f --rebase     
  

      IF ERRORLEVEL 1 (
          echo pulled fail, need clean unstaged changes
          git checkout .
          git pull -f --rebase   
        )
      git push
      )
      
         IF ERRORLEVEL 1 (
         echo push fail
         pause
         )
         else (
         echo push success
         )

    


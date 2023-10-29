# RV32I
Digital上でRV32Iを構築して、色々なプログラムを動かしてみる趣旨。  
top.digファイルをDigital (logisim digital で検索すると出ます。)で開いて、makeすればAssemblerフォルダ上にある様々なプログラムを動かせます。  
  
配布前提ではないため、ファイルパスなどの細々としたエラーは出るかもしれません。  
また、makeとcustomasmを導入して環境パスに設定しないと、makeはできません。  
また、make時に使用するhex2logiアプリケーションは、MinGW環境でビルドしているので、多分Windows以外では動きません。その場合はhex2logi.cを新たにビルドしてください。

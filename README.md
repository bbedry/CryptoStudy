# CryptoStudy

Projeyi MVC design pattern ile geliştirdim. Çünkü uygulamada ekran sayısı iki ekranla sınırlıydı. 
UIImage, UIView ve custom tableView Cell reusable için extension ekledim.
Uygulama henüz markete çıkmaya hazır değil. Düzeltilmesi gereken minor akışlar var. 
Coin görsellerinin bazıları svg bazıları png formatlıydı. Burada servisten gelen datada url'nin uzantısını kontrol ederek Kingfisher+SVGKit ile indirmeye çalıştım. 
Görsellerin yüklenmesinde herhangi bir sorun yoktu fakat tableview'i reload ettirmeye çalıştığımda ya da scroll ettiğimde svg formatlı görselleri convert etmeye çalıştığım yerde ilk datanın urlsini parse edemiyor.
Bu yüzden app crash oluyordu. (CALayer error) SVGKit kütüphanesini kaldırıp SDWebImage kütüphanesini import ettim. Daha sonra kütüphanenin SVGDecoder methodu ile aldığım urlyi decode ettim.
Filter Button tarafında basit bir çözüm için UIPickerView kullandım. UI önemli olduğunda dropdown pod ya da swiftUI ile daha doğru konumlandırılmış ve daha estetik bir açılır dropdown menu tasarlanabilir.



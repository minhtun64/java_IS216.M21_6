# <h1 align="center">java_IS216.M21_6<h1>
  <div align="center">
  <a href="">
  </a>

  <h3 align="center">Thanh Xuân</h3>

  <p align="center">
    Hệ thống quản lý bán vé xe khách
    <br />
    <a href="https://github.com/minhtun64uit/java_IS216.M21_6/tree/main"><strong>Khám phá »</strong></a>
    <br />
  </p>
    
    
    
</div>
  <!-- TABLE OF CONTENTS -->
<details>
  <summary>Mục lục</summary>
  <ol>
    <li><a href="#muctieu">Mục tiêu đồ án</a></li>
    <li><a href="#dsthanhvien">Danh sách thành viên</a></li>
    <li><a href="#chucnang">Các chức năng</a></li>
    <li><a href="#chucnangnangcao">Chức năng nâng cao</a></li>
    <li><a href="#yeucau">Yêu cầu hệ thống</a></li>
    <li><a href="#mohinh">Mô hình</a></li>
    <li><a href="#congnghe">Công nghệ sử dụng</a></li>
    <li><a href="#lienhe">Liên hệ</a></li>
    <li><a href="#thuvien">Thư viện sử dụng</a></li>
    <li><a href="#thamkhao">Tài liệu tham khảo</a></li>
  </ol>
</details>
  
  
  <!-- ABOUT THE PROJECT -->
# <h2 id="muctieu">Mục tiêu của đồ án</h2>
Đây là project của môn học Lập trình Java. Nội dung là tạo một phần mềm quản lý mua bán vé xe khách.

Phần mềm phải đảm bảo được các mục tiêu:
- Giúp hành khách mua vé được nhanh chóng và thuận tiện hơn.
- Tiện lợi cho nhân viên, người quản lý dễ dàng kiểm soát và cập nhật thông tin.
- Giao diện đơn giản, dễ sử dụng.
# <h2 id="dsthanhvien">Danh sách thành viên trong nhóm</h2>
<table>
<tr>
  <b>Danh sách thành viên trong nhóm</b>

</tr>
<tr>
  <td>Họ Và Tên</td>
  <td>MSSV</td>
  <td>Facebook</td>
  <td>SĐT</td>
  <td>Nhiệm vụ</td>
  <td>Đánh giá %<td>
</tr>
<tr>
  <td>Đặng Minh Tuấn</td>
  <td>20522106</td>
  <td><a href="https://www.facebook.com/minhtuan644">Minh Tuấn</a></td>
  <td>0949385911</td>
  <td>Thiết kế database</td>
  <td>25</td>
</tr>
  <tr>
  <td>Nông Tiến Dũng</td>
  <td>20521212</td>
  <td><a href="https://www.facebook.com/nongtiendung.2309/">Tiến Dũng</a></td>
  <td>0335594771</td>
  <td>Code Frontend</td>
  <td>25</td>
</tr>
  <tr>
  <td>Nguyễn Đức Thuần</td>
  <td>20521993</td>
  <td><a href="https://www.facebook.com/profile.php?id=100014732828317">Đức Thuần</a></td>
  <td>0886339784</td>
  <td>Thiết kế database</td>
   <td>25</td>
</tr>
  <tr>
  <td>Nguyễn Duy Tài</td>
  <td>20520299</td>
  <td><a href="https://www.facebook.com/duytai800">Duy Tài</a></td>
  <td>0335586347</td>
  <td>Code backend</td>
  <td>25</td>
</tr>
</table>
<!-- #Hệ Thống Quản Lý Mua Bán Vé Xe Khách
<p>Nhiều năm gần đây xe khách đã dần trở thành phương tiện được nhiều người lựa chọn vì chi phí thấp, di chuyển nhanh chóng mà vẫn đảm bảo sự an toàn. Tuy nhiên, cách mua và bán vé xe khách truyền thống đã không đáp ứng được mong muốn của cả các khách hàng và hãng xe, như còn nhiều cảnh chen lấn để mua vé, hay các công ty vận tải gặp khó khăn trong việc quản lý và tổ chức bán vé xe. Muốn đáp ứng nhu cầu thị trường, ta cần quản lý một lượng lớn thông tin như số vé xe khách bán ra mỗi ngày, thông tin chuyến xe, thông tin khách hàng, thống kê doanh thu, … Tất cả đều là những nghiệp vụ lớn, nếu thực hiện thủ công mà không có sự hỗ trợ của công nghệ ứng dụng sẽ dễ gặp phải những vấn đề như nhầm lẫn thông tin, mất mát dữ liệu, thao tác xử lý chậm, tốn kém mà không hiệu quả. </p>
<p> Ngày nay khi mà công nghệ thông tin phát triển mạnh, mạng Internet về tận từng hộ gia đình, người dân thường xuyên tiếp xúc với máy tính và Internet thì hệ thống ra đời là rất phù hợp với tình hình thực tiễn. Nhu cầu đi đi xe khách ngày càng tăng đi kèm với các thao tác giao dịch mua bán trên các hệ thống cần phải đảm bảo tốc độ nhanh chóng, đáp ứng đầy đủ nhu cầu sử dụng dịch vụ khách hàng. Chính vì lẽ đó, đồ án lần này của nhóm chúng tôi hướng đến việc phân tích, thiết kế và triển khai hệ thống mua bán vé xe khách, với những tính năng đa dạng và giao diện dễ dàng sử dụng đối với tất cả mọi người.</p> -->

# <h2 id="chucnang">Tóm tắt chức năng</h2>
- Khách hàng:<br/>
  + Đặt mua vé xe.
  + Xem các chuyến xe, giờ xe khách đi.
  + Xem thông tin đặt vé.
- Nhân viên:<br/>
  + Đăng nhập
  + Quản lý hoàn vé.
  + Quản lý khách hàng.
  + Quản lý Đặt vé.
- Ban quản lý:<br/>
  + Đăng nhập
  + Quản lý tuyến xe.
  + Quản lý chuyến xe.
  + Quản lý xe.
  + Quản lý loại xe.
  + Quản lý giá vé.
  + Quản lý nhân viên.
  
# <h2 id="chucnangnangcao">Chức năng nâng cao
- Vẽ biểu đồ cột
- Hoàn vé theo ngày
- Xuất exe
  
# <h2 id="yeucau">Yêu cầu hệ thống
- Oracle Database
- JDK 17
  
# <h2 id="mohinh">Mô hình dữ liệu
![sơ đồ 2](https://user-images.githubusercontent.com/87002579/174849576-32886079-ca1e-4a24-848f-0babb573accb.png)


# <h2 id="congnghe">Công nghệ sử dụng
- <a href="https://netbeans.apache.org/">Apache NetBeans</a>
- <a href="https://www.oracle.com/index.html">Oracle database</a>
<!-- 

<details>
  <summary>Công nghệ sử dụng</summary>
  <ol>
    <li><a href="https://netbeans.apache.org/">Apache NetBeans</a></li>
    <li><a href="https://www.oracle.com/index.html">Oracle database</a></li>
  </ol>
</details> -->
## <h2 id="lienhe">Liên hệ</h2>


Project Link: [https://github.com/minhtun64uit/java_IS216.M21_6/tree/main) </br>
Email: [---](-----)
## <h2 id="thuvien">Thư viện sử dụng</h2>
- ojdbc11.jar
- jcalendar-1.2.2.jar
- commmons-beanutils-1.8.0.jar
- commmons-collections-2.1.1.jar
- commmons-digester-2.1.jar
- commmons-logging-1.1.1.jar
- dom4j-1.6.1.jar
- groovy-all-2.0.1.jar
- itextpdf-5.5.0.jar
- jasperreports-5.5.0.jar
- jasperreports-fonts-5.5.0.jar
- jasperreports-javaflow-5.5.0.jar
- javax.servlet-5.1.12.jar

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
    <li>
      <a>Mục tiêu đồ án</a>
    </li>
    <li>
      <a href="#dsthanhvien">Danh sách thành viên</a>
    </li>
    <li><a href="#framework">Các Framework</a></li>
    <li>
      <a href="#chucnang">Các chức năng</a>
    </li>
    <li><a href="#yeucau">Yêu cầu hệ thống</a></li>
    <li>
      <a href="#caidat">Cài đặt và sử dụng</a>
      <ul><a href="#setup">Setup môi trường</a></ul>
      <ul><a href="#start">Khởi động dự </a></ul>
    </li>
    <li><a href="#lienhe">Liên hệ</a></li>
    <li><a href="#banquyen">Bản quyền</a></li>
    <li><a href="#thamkhao">Tài liệu tham khảo</a></li>
  </ol>
</details>
  
  
  <!-- ABOUT THE PROJECT -->
<h2 id="muctieu">Mục tiêu của đồ án</h2>
Đây là project của môn học Xây dựng hệ thống thông tin trên các Framework - UIT. Nội dung là tạo một trang web quản lý chuỗi bán lẻ cà phê và sách

Trang web phải đảm bảo được các mục tiêu:
- Giúp khách hàng mua hàng được nhanh chóng và đúng sản phẩm mình cần.
- Tiện lợi cho người bán hàng dễ dàng quản lý cửa hàng của mình.
- Giao diện đơn giản, load nhanh.
  <h2 id="dsthanhvien">Danh sách thành viên trong nhóm</h2>
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
  <td>Nhóm trưởng</td>
  <td>------</td>
</tr>
  <tr>
  <td>Nông Tiến Dũng</td>
  <td>20521212</td>
  <td><a href="https://www.facebook.com/nongtiendung.2309/">Tiến Dũng</a></td>
  <td>0335594771</td>
  <td>------</td>
    <td>------</td>
</tr>
  <tr>
  <td>Nguyễn Đức Thuần</td>
  <td>20521993</td>
  <td><a href="https://www.facebook.com/profile.php?id=100014732828317">Đức Thuần</a></td>
  <td>0886339784</td>
  <td>Thiết kế database</td>
   <td>------</td>
</tr>
  <tr>
  <td>Nguyễn Duy Tài</td>
  <td>20520299</td>
  <td><a href="https://www.facebook.com/duytai800">Duy Tài</a></td>
  <td>0335586347</td>
  <td>----------</td>
  <td>------</td>
</tr>
</table>
#Hệ Thống Quản Lý Mua Bán Vé Xe Khách
<p>Nhiều năm gần đây xe khách đã dần trở thành phương tiện được nhiều người lựa chọn vì chi phí thấp, di chuyển nhanh chóng mà vẫn đảm bảo sự an toàn. Tuy nhiên, cách mua và bán vé xe khách truyền thống đã không đáp ứng được mong muốn của cả các khách hàng và hãng xe, như còn nhiều cảnh chen lấn để mua vé, hay các công ty vận tải gặp khó khăn trong việc quản lý và tổ chức bán vé xe. Muốn đáp ứng nhu cầu thị trường, ta cần quản lý một lượng lớn thông tin như số vé xe khách bán ra mỗi ngày, thông tin chuyến xe, thông tin khách hàng, thống kê doanh thu, … Tất cả đều là những nghiệp vụ lớn, nếu thực hiện thủ công mà không có sự hỗ trợ của công nghệ ứng dụng sẽ dễ gặp phải những vấn đề như nhầm lẫn thông tin, mất mát dữ liệu, thao tác xử lý chậm, tốn kém mà không hiệu quả. </p>
<p> Ngày nay khi mà công nghệ thông tin phát triển mạnh, mạng Internet về tận từng hộ gia đình, người dân thường xuyên tiếp xúc với máy tính và Internet thì hệ thống ra đời là rất phù hợp với tình hình thực tiễn. Nhu cầu đi đi xe khách ngày càng tăng đi kèm với các thao tác giao dịch mua bán trên các hệ thống cần phải đảm bảo tốc độ nhanh chóng, đáp ứng đầy đủ nhu cầu sử dụng dịch vụ khách hàng. Chính vì lẽ đó, đồ án lần này của nhóm chúng tôi hướng đến việc phân tích, thiết kế và triển khai hệ thống mua bán vé xe khách, với những tính năng đa dạng và giao diện dễ dàng sử dụng đối với tất cả mọi người.</p>

<details>
  <summary>Chức năng.</summary>
  <ol>
    <li>
      <a>Khách hàng.</a>
      <ul>
        <li><a>Đặt mua vé xe.</a></li>
        <li><a>Xem các chuyến xe, giờ xe khách đi.</a></li>
        <li><a>Xem thông tin khuyến mãi.</a></li>
        <li><a>Xem các thông tin quy định của xe.</a></li>
      </ul>
    </li>
    <li>
      <a>Nhân viên.</a>
      <ul>
        <li><a>Quản lý vé.</a></li>
        <li><a>Quản lý hoàn vé.</a></li>
        <li><a>Quản lý khách hàng.</a></li>
        <li><a>Quản lý khuyến mãi.</a></li>
        <li><a>Tất cả chức năng của khách hàng.</a></li>
      </ul>
    </li>
    <li>
      <a>Ban quản lý.</a>
      <ul>
        <li><a>Quản lý tuyến xe.</a></li>
        <li><a>Quảy lý chuyến xe.</a></li>
        <li><a>Quản lý xe.</a></li>
        <li><a>Quản lý loại xe.</a></li>
        <li><a>Quản lý ghế.</a></li>
        <li><a>Quản lý giá vé.</a></li>
        <li><a>Quản lý nhân viên.</a></li>
        <li><a>Thống kê doanh thu.</a></li>
        <li><a>Tất cả các chức năng của nhân viên trừ các chức năng đã phân quyền.</a></li>
      <ul>
    </li>
  </ol>
</details>
<details>
     <summary>Mô hình dữ liệu</summary>
</details>


![ERD (16)](https://user-images.githubusercontent.com/87002579/170882725-2e22ab68-71d1-43b7-8776-138507cfb12d.jpg)




<details>
  <summary>Công nghệ sử dụng</summary>
  <ol>
    <li><a href="https://netbeans.apache.org/">Apache NetBeans</a></li>
    <li><a href="https://www.oracle.com/index.html">Oracle database</a></li>
  </ol>
</details>

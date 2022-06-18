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
<table>
<tr>
  <th colspan="6"><b>Thông tin thành viên trong nhóm</b></th>

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
  <ol>
  <li><img src="![ERD (16)](https://user-images.githubusercontent.com/87002579/170882725-2e22ab68-71d1-43b7-8776-138507cfb12d.jpg)"></li>
  </ol>
</details>

<!-- 
![ERD (16)](https://user-images.githubusercontent.com/87002579/170882725-2e22ab68-71d1-43b7-8776-138507cfb12d.jpg) -->




<details>
  <summary>Công nghệ sử dụng</summary>
  <ol>
    <li><a>Apache NetBeans</a></li>
    <li><a>Oracle database</a></li>
  </ol>
</details>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="../../resources/css/adminProduct.css"/>
<script>
    function getSearchList() {
        $.ajax({
            type: 'GET',
            url: "/searchProduct.do",
            data: $("form[name=search-form]").serialize(),
            success: function (result) {
                console.log(result)
                $("#table_container").html(result);
            }
        })
    }
</script>
<html>
<body>
<div class="cardBox">
    <a href=# onclick="loadProduct()">
        <div class="card">
            <div>
                <div class="numbers">${productList.size()}개</div>
                <div class="cardName">총 상품</div>
            </div>
            <div class="iconBox">
                <i class="fa fa-cubes" aria-hidden="true"></i>
            </div>
        </div>
    </a>
    <a href=# onclick="loadProduct()">
        <div class="card">
            <div>
                <div class="numbers">${productTodayList.size()}개</div>
                <div class="cardName">오늘 올라온 상품</div>
            </div>
            <div class="iconBox">
                <i class="fa fa-clock-o" aria-hidden="true"></i>
            </div>
        </div>
    </a>
    <a href=# onclick="loadMember()">
        <div class="card">
            <div>
                <div class="numbers">${orderFinishedList.size()}개</div>
                <div class="cardName">거래 완료 된 상품</div>
            </div>
            <div class="iconBox">
                <i class="fa fa-check-square-o" aria-hidden="true"></i>
            </div>
        </div>
    </a>
    <div class="card">
        <div>
            <%--JSTL 사용, 세 자리 수마다 콤마(,) 삽입--%>
            <div class="numbers"><fmt:formatNumber value="${sum}" type="number" pattern="#,###"/>원</div>
            <div class="cardName">총 거래량</div>
        </div>
        <div class="iconBox">
            <i class="fa fa-usd" aria-hidden="true"></i>
        </div>
    </div>
</div>
<div class="details">
    <div class="recentOrders">
        <div class="cardHeader">
            <h2>상품 목록</h2>
            <form name="search-form" autocomplete="off">
            <span style="text-align: right">
                <select name="search_type" style="font-size: 1.0rem">
                    <option value="product_id">No</option>
                    <option value="member_id">판매자</option>
                </select>
                <input name="search_index" style="font-size: 18px" placeholder="검색 할 값 입력">
                <input class="btn" type="button" onclick="getSearchList()" value="검색"></input>
             </span>
            </form>
        </div>
        <div id="table_container">
            <table id="boardtable">
                <thead>
                <tr>
                    <td>상품 ID</td>
                    <td>등록일시</td>
                    <td>상품명</td>
                    <td>판매자</td>
                    <td>판매가격</td>
                    <td>조회수</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productList}" var="productList">
                    <tr>
                        <td>
                                ${productList.productId}
                        </td>
                        <td>
                            <fmt:formatDate value="${productList.savedTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </td>
                        <td>
                                ${productList.productName}
                        </td>
                        <td>
                                ${productList.memberId}
                        </td>
                        <td>
                            <fmt:formatNumber value="${productList.price}" type="number" pattern="#,###"/>원
                        </td>
                        <td>
                                ${productList.productViews}회
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="recentCustomers">
        <div class="cardHeader">
            <h2>최근 결제 된 상품</h2>
        </div>
        <table>
            <thead>
            <tr>
                <td>상품 ID</td>
                <td>결제 시각</td>
                <td>구매자</td>
                <td>판매자</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orderList}" var="bag">
                <tr>
                    <td>${bag.productId}</td>
                    <td><fmt:formatDate value="${bag.paymentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>${bag.buyerId}</td>
                    <td>${bag.sellerId}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

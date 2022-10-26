class 클래스 extends HTMLElement {
  connectedCallback() {
    this.innerHTML = ` <header class="header-box">
                <div class="header-menu-logo-box">
                    <span><img src="../../../../resources/static/pictures/menu-icon.png" class="header-menu-button"></span>
                    <span><a href="http://localhost:8090/allproduct">Connect Us</a></span>
                </div>
                <div class="header-search-box">
                    <div class="input-group header-search-box-inner">
                        <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary" type="button" id="button-addon2">Button</button>
                    </div>
                </div>
                <div class="header-sign-box">
                    <!-- <% if(session.getAttribute("sessionid") == null) { %> -->
                    <a class="loginBtn" href="../login">로그인</a>
                     <!-- <% } else { %> -->
                    <!-- <a href="/memberupdate" class="mypage">마이페이지 </a>
                    <a id="logoutchk" href="/logout" class="mypage">로그아웃</a> -->
            <!-- <% } %> -->
                </div>
            </header>
            <!--Navbar-->
            <nav class="nav-box">
                <div class="basic-menu-box">
                <div class="nav-menu-box">
                    <span class="menu-icon"><img src="../../../../resources/static/pictures/product.png" alt=""></span>
                    <div class="menu-title close"><a href="/">전체 물품</a></div>
                </div>
                <div class="nav-menu-box">
                <span class="menu-icon"><img src="../../../../resources/static/pictures/neighbor.png" alt=""></span>
                <div class="menu-title close"><a href="/">내 이웃</a></div>
                </div>
                <div class="nav-menu-box">
                    <span class="menu-icon"><img src="../../../../resources/static/pictures/community.png" alt=""></span>
                    <span class="menu-title close"><a href="/">커뮤니티</a></span>
                </div>
                </div>
                <div class="after-login-menu-box">
                    <div class="nav-menu-box">
                        <span class="menu-icon"><img src="../../../../resources/static/pictures/chat.png" alt=""></span>
                        <span class="menu-title close"><a href="">채팅시스템</a></span>
                    </div>
                </div>
            </nav>`;
  }
}
customElements.define("custom-header", 클래스);

let menu = document.querySelector(".header-menu-button");
let menuTitle = document.querySelectorAll(".menu-title");

menu.addEventListener("click", function () {
  for (let i = 0; i < 4; i++) {
    menuTitle[i].classList.toggle("close");
  }
});

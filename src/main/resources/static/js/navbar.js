


        class 클래스 extends HTMLElement {
            connectedCallback(){
                this.innerHTML = 
                `<div class="main-container-top">
            <div class="main-logo">
                <span>Connect Us</span>
            </div>
            <div class="main-login">
                <span style="margin-right:15px">로그인</span>
                <span>고객센터</span>
            </div>
        </div>
        <div class="main-container-title">
            <span><img src="/src/images/connectus.png"></span>
            <span>Connect Us</span>
        </div>
        <nav class="nav-container">
            <nav class="navbar navbar-expand-lg main-navbar">
                <a class="nav-link" href="#">가전제품</a>
                <a class="nav-link" href="#">애완용품</a>
                <a class="nav-link disabled">등산용품</a>
                <a class="nav-link disabled">내 이웃</a>
                <a class="nav-link disabled">커뮤니티</a>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </nav>
        </nav>`
            }
        }
        customElements.define("custom-navbar", 클래스);
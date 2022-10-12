let resultBox = document.querySelector('.smart-search-result-box');
let smartKeyword = document.querySelectorAll('.smart-keyword')


function printName0(){
        let keyword = document.querySelectorAll('.smart-keyword')[0].value;
        let div = document.createElement('div');
        let close = document.createElement('button');
        close.innerText = "x";
        close.className = "closebutton"
        div.innerText = keyword;
        div.appendChild(close);
        resultBox.appendChild(div);
        
        close.addEventListener('click', function(event){
            const li = event.target.parentElement;
            li.remove();
            smartKeyword[0].value = "";
        })
}


function printName1(){
    let keyword = document.querySelectorAll('.smart-keyword')[1].value;
    let div = document.createElement('div');
    let close = document.createElement('button');
    close.innerText = "x";
    close.className = "closebutton"
    div.innerText = keyword;
    div.appendChild(close);
    resultBox.appendChild(div);
    
    close.addEventListener('click', function(event){
        const li = event.target.parentElement;
        li.remove();
        smartKeyword[1].value = "";
    })
}

function printName2(){
    let keyword = document.querySelectorAll('.smart-keyword')[2].value;
    let div = document.createElement('div');
    let close = document.createElement('button');
    close.innerText = "x";
    close.className = "closebutton"
    div.innerText = keyword;
    div.appendChild(close);
    resultBox.appendChild(div);
    
    close.addEventListener('click', function(event){
        const li = event.target.parentElement;
        li.remove();
        smartKeyword[2].value = "";
    })
}


//찜 리스트

const draggable = ($target) => {
    let isPress = false,
        prevPosX = 0,
        prevPosY = 0;
    
    $target.onmousedown = start;
    $target.onmouseup = end;
      
    // 상위 영역
    window.onmousemove = move;
   
    function start(e) {
      prevPosX = e.clientX;
      prevPosY = e.clientY;
  
      isPress = true;
    }
  
    function move(e) {
      if (!isPress) return;
  
      const posX = prevPosX - e.clientX; 
      const posY = prevPosY - e.clientY; 
      
      prevPosX = e.clientX; 
      prevPosY = e.clientY;
      
      $target.style.left = ($target.offsetLeft - posX) + "px";
      $target.style.top = ($target.offsetTop - posY) + "px";
    }
  
    function end() {
      isPress = false;
    }
  }
  
  window.onload = () => {
    const $target = document.querySelector(".zzimproduct-list-container");
    
    draggable($target);
  }

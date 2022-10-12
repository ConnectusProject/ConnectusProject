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




let resultBox = document.querySelector('.smart-search-result-box');
let smartKeyword = document.querySelectorAll('.smart-keyword')



function printName(){
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
        })
}

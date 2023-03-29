function setUserName(){
	let myName = prompt('Please enter your name.');/*像 alert，不過會要求 user 輸入內容*/
	if(!myName || myName === null){
		setUserName()
	}else{
		localStorage.setItem('name', myName);
		myHeading.innerHTML = 'Hello, ' + myName + '!';
	}
} 

var myImage = document.querySelector('img');
var myButton = document.querySelector('Button');
var myHeading = document.querySelector('h1');



myImage.onclick = function(){
	let mySrc = myImage.getAttribute('src');
	if (mySrc === 'images/cat.jpg'){
		myImage.setAttribute('src', 'images/cat2.jpg');
	}else{
		myImage.setAttribute('src', 'images/cat.jpg');
	}
}

if(!localStorage.getItem('name')){
	setUserName();
}else{
	let storedName = localStorage.getItem('name');
	myHeading.innerHTML = 'Hello, ' + storedName + '!';
}

myButton.onclick = function(){
	setUserName();
}
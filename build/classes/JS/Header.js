
const menu = document.querySelector('.menu');

document.addEventListener('scroll', function() {

	var scroll_position = window.scrollY;

	if(scroll_position > 250)
		menu.style.backgroundColor = '#29323c';
	else
	{
		menu.style.backgroundColor = 'transparent';
	}
})

document.addEventListener("DOMContentLoaded", function() {
  // JavaScript para adicionar a classe ativo ao item de menu clicado
  var menuItems = document.querySelectorAll('.item-menu');

  menuItems.forEach(function(item) {
    item.addEventListener('click', function() {
      // Remove a classe ativo de todos os itens de menu
      menuItems.forEach(function(item) {
        item.classList.remove('ativo');
      });
      // Adiciona a classe ativo ao item de menu clicado
      this.classList.add('ativo');
    });
  });

  // JavaScript para expandir/recolher a barra lateral
  var btnExp = document.querySelector('#btn-exp');
  var menuSide = document.querySelector('.menu-lateral');

  btnExp.addEventListener('click', function() {
    menuSide.classList.toggle('expandir');
  });
});
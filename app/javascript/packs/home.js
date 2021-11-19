const addButton = document.querySelector('.todo-button');
const addTodo = () => {
  alert('追加');
};
if( addButton !== null ){
  addButton.addEventListener('click', addTodo);
}
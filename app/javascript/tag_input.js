if (location.pathname.match("items/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const tagInput = document.getElementById("item-tag"),
          TagLists = document.getElementById("tag_lists"),
          addBtn = document.getElementById('tag_add_btn');
    let tagCount = 0;

    addBtn.addEventListener("click", () => {
      if (tagInput.value != '') {
        const registrationTag = document.createElement('div');
        registrationTag.setAttribute('id', "tag_element");
        registrationTag.setAttribute('class', 'tag-element');
        tagText = document.createElement('div');
        tagText.innerHTML = tagInput.value;
        registrationTag.appendChild(tagText);
        const deleteBtn = document.createElement('i');
        deleteBtn.setAttribute('class', "far fa-times-circle tag-delete-btn");
        deleteBtn.setAttribute('id', "tag_delete_btn");
        registrationTag.appendChild(deleteBtn);
        let registrationTagNum = tagCount;
        const inputHTML = document.createElement('input');
        inputHTML.setAttribute('id', `item_tag_${registrationTagNum}`);
        inputHTML.setAttribute('name', 'item_tag[tag_names][]');
        inputHTML.setAttribute('type', 'text');
        inputHTML.setAttribute('class', 'hide');
        registrationTag.appendChild(inputHTML);
        TagLists.appendChild(registrationTag);
        let registrationTagInput = document.getElementById(`item_tag_${registrationTagNum}`);
        registrationTagInput.value = tagInput.value;
        tagInput.value = "";
        tagCount += 1;
      };
    });

    $('#tag_lists').on('mouseover', function (){
      $('#tag_lists #tag_delete_btn').on('click', function () {
        $(this).parent().remove();
      });
    })
  });
};
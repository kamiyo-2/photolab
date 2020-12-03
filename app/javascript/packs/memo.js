function memo() {
 const submit = document.getElementById("submit");
 submit.addEventListener("click", (e) => {
   const formData = new FormData(document.getElementById("form"));
   const XHR = new XMLHttpRequest();
   XHR.open("COMMENT", "/comments", true);
   XHR.responseType = "json";
   XHR.send(formData);
   XHR.onload = () => {
     if (XHR.status != 200) {
       alert(`Error ${XHR.status}: ${XHR.statusText}`);
       return null;
     }
     const item = XHR.response.comment;
     const list = document.getElementById("list");
     const formText = document.getElementById("content");
     const HTML = `
       <div class="comment" data-id=${item.id}>
         <div class="comment-date">
           投稿日時：${item.created_at}
         </div>
         <div class="comment-content">
         ${item.content}
         </div>
       </div>`;
     list.insertAdjacentHTML("afterend", HTML);
     formText.value = "";
   };
   e.preventDefault();
 });
}
window.addEventListener("load", memo);
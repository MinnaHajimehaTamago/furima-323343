import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<div class="comment">
                    <div class="comment-left">
                      <p>${data.content.nickname}:</p>
                    </div>
                    <div class="comment-right">
                      <p>${data.content.text}</p>
                    </div>
                  </div>`;
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
  }
});
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['newCommentForm', 'comments']

  toggleVisibility () {
    this.newCommentFormTarget.classList.toggle('hidden')
    this.commentsTarget.classList.toggle('hidden')
  }
}

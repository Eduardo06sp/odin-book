import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal', 'uploadUrl', 'uploadFile']

  display () {
    this.modalTarget.showModal()
  }

  clearValue (element) {
    element.value = ''
  }

  cancel () {
    this.clearValue(this.uploadUrlTarget)
    this.clearValue(this.uploadFileTarget)
    this.close()
  }

  close () {
    this.modalTarget.close()
  }
}

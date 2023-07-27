import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal', 'uploadUrl', 'uploadFile']

  display () {
    this.modalTarget.showModal()
  }

  clearValue (element) {
    element.value = ''
  }

  save () {
    if (this.uploadUrlTarget.checkValidity()) {
      this.close()
    } else {
      this.uploadUrlTarget.reportValidity()
    }
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

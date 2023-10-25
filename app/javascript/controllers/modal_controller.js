import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  hideBeforeRender(event) {
    if (this.isOpen()) {
      event.preventDefault()
      this.element.addEventListener('hidden.bs.modal', event.detail.resume)
      this.modal.hide()
      this.resetFrame()
    }
  }

  isOpen() {
    return this.element.classList.contains("show")
  }

  resetFrame(){
    const modal_frame = document.getElementById('remote_modal')
    modal_frame.innerHTML = ''
    modal_frame.removeAttribute('src')
    modal_frame.removeAttribute('complete')
  }
}

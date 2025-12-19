import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  static targets = ['menu']
  connect() {

  }

  async toggleInterviewer(event) {
    const checkbox = event.target
    const userId = checkbox.dataset.userId
    const openingId = checkbox.dataset.openingId
    const checked = checkbox.checked

    fetch(`/openings/${openingId}/toggle_interviewer`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ user_id: userId, checked: checked })
    })
      .then(response => {
        if (!response.ok) {
          checkbox.checked = !checked // revert if failed
          alert("Could not update interviewer selection.")
        }
      })
  }
}

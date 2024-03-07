import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  static targets = ['menu']
  connect() {

  }

  async change({ params }) {
    const request = new FetchRequest('patch', `/candidates/${params.candidate}/update`, { body: JSON.stringify({ bucket: params.bucket }), responseKind: 'turbo-stream' })
    const response = await request.perform()
  }
}

import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  static targets = ['menu']
  connect() {

  }

  async change({ params }) {
    const request = new FetchRequest('patch', `/candidates/${params.candidate}/update/status`, { body: JSON.stringify({ status: params.status }), responseKind: 'turbo-stream' })
    const response = await request.perform()
  }
}

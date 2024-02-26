import { Controller } from "@hotwired/stimulus"
import Dropdown from "flowbite/plugins/dropdown";
export default class extends Controller {
    static targets = ['menu']
  connect() {
    
  }

  change({ params }) {
    console.log(params)
  }
}

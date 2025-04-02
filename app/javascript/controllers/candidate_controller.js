import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
    static targets = ['menu']
    connect() {
    }


    async update_owner({ params }) {
        const request = new FetchRequest('patch', `/candidates/${params.candidate}/update/owner`, {
            body: JSON.stringify({ owner_id: params.owner }), responseKind: 'turbo-stream'
        })
        const response = await request.perform()
    }

    async update_bucket({ params }) {
        const request = new FetchRequest('patch', `/candidates/${params.candidate}/update/bucket`, {
            body: JSON.stringify({ bucket: params.bucket }), responseKind: 'turbo-stream'
        })
        const response = await request.perform()
    }

    async update_status({ params }) {
        const request = new FetchRequest('patch', `/candidates/${params.candidate}/update/status`, {
            body: JSON.stringify({ status: params.status }), responseKind: 'turbo-stream'
        })
        const response = await request.perform()
    }

    async update_campaign({ params }) {
        const request = new FetchRequest('patch', `/candidates/${params.candidate}/update/campaign`, {
            body: JSON.stringify({ campaign_id: params.campaign }), responseKind: 'turbo-stream'
        })
        const response = await request.perform()
    }

    async toggle_recycle({ params }) {
        const request = new FetchRequest('patch', `/candidates/${params.candidate}/toggle/recycle`, {
            body: JSON.stringify({ status: params.candidate }), responseKind: 'turbo-stream'
        })
        const response = await request.perform()
    }

}

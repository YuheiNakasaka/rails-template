import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['name', 'output']

  declare readonly nameTarget: HTMLInputElement
  declare readonly outputTarget: HTMLInputElement

  connect() {
    console.log('connected!')
  }

  greet() {
    this.outputTarget.value = `Hello, ${this.nameTarget.value}!`
  }
}

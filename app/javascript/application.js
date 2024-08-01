// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

window.show = () => {
    document.getElementById("top-menu").classList.add("show");

}
window.hide = () => document.getElementById("top-menu").classList.remove("show");

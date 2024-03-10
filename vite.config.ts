import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
import FullReload from 'vite-plugin-full-reload'

export default defineConfig({
  clearScreen: false,
  plugins: [RubyPlugin(), StimulusHMR(), FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 })],
  root: './app/assets',
  build: {
    manifest: true,
    rollupOptions: {
      input: '/app/javascript/entrypoints/application.ts',
    },
  },
})

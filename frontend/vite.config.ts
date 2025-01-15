import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/',
  build: {
    outDir: 'dist',
  },
  server: {
    proxy: {
      '/api': {
        target: 'https://5174-kalfanet-claudeplus-i3lgnlz7xdr.ws-us117.gitpod.io',
        changeOrigin: true,
      }
    }
  }
})
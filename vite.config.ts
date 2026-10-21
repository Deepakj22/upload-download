import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  base: "/ada-backend/",
  plugins: [react()],
  server: {
    port: 5173,
    strictPort: true,
  },
});

import { defineConfig } from "astro/config";
import icon from "astro-icon";
import tailwindcss from "@tailwindcss/vite";

const build = {
  baseURL: "/",
  outDir: "./dist",
  siteURL: "http://localhost:4321/",
};

const env = process.env.NODE_ENV;

switch (env) {
  case "production":
    build.siteURL = "https://stashsphere.com/";
    break;

  default:
    break;
}

// https://astro.build/config
export default defineConfig({
  site: build.siteURL,
  base: build.baseURL,
  outDir: build.outDir,
  integrations: [icon()],
  vite: { plugins: [tailwindcss()] },
});

import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config

export default defineConfig({

  title: "HxMinetest",
  description: "Documentation",

  ignoreDeadLinks: true,

  themeConfig: {

    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Guide', link: '/guide/getting-started' },
      { text: 'Reference', link: '/reference/' }
    ],

    sidebar: {

      "/guide/": [
        {
          text: 'Introduction',
          items: [
            { text: 'About HxMinetest', link: '/guide/about' },
            { text: 'Getting started', link: '/guide/getting-started' },
          ]
        },
        {
          text: 'Writing mods',
          items: [
            { text: 'Your first mod', link: '/guide/tutorial/your-first-mod' },
          ]
        }
      ],

      "/reference/": [
        {
          text: 'Reference',
          items: [
            { text: 'index', link: '/reference/' },
          ]
        }
      ],

    },

    socialLinks: [
      {
        icon: 'github',
        link: 'https://github.com/frixuu/hxminetest/',
      }
    ]
  }
})

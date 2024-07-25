// https://vitepress.dev/guide/custom-theme
import Theme from 'vitepress/theme';
import { h } from 'vue';
import MethodSignature from './MethodSignature.vue';
import PropertySignature from './PropertySignature.vue';
import './style.css';

export default {
  extends: Theme,
  Layout: () => {
    return h(Theme.Layout, null, {
      // https://vitepress.dev/guide/extending-default-theme#layout-slots
    })
  },
  enhanceApp({ app, router, siteData }) {
    app.component('MethodSignature', MethodSignature);
    app.component('PropertySignature', PropertySignature);
  }
}

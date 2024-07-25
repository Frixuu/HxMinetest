<script setup lang="ts">

import TypeRef from './TypeRef.vue';
import { RuntimeType } from './haxe-types';

defineProps<{name: string, type: RuntimeType}>();

</script>

<template>
  <span>
    <slot name="pre"></slot>
    <span class="code">
      <strong class="name">{{ name }}</strong>:
      <span class="type"><TypeRef :type="type" /></span>
      <slot></slot>
    </span>
    <slot name="post"></slot>
  </span>
</template>

<style scoped lang="scss">
  .code {
    font-family: var(--vp-font-family-mono);
  }
</style>

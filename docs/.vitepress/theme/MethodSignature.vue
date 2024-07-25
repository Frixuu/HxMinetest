<script setup lang="ts">

import TypeRef from './TypeRef.vue';
import { FunctionArgument, RuntimeType } from './haxe-types';

defineProps<{name: string, args: FunctionArgument[], returnType: RuntimeType}>();

function isRest(type: RuntimeType): boolean {
  const { pack, module, name } = type.path;
  return pack.length == 1 && pack[0] == 'haxe' && module == 'Rest' && name == "Rest";
}

</script>

<template>
  <span>
    <slot name="pre"></slot>
    <span class="code">
      <strong class="name">{{ name }}</strong><span class="everything-but-name"><span class="params">(<span v-for="(arg, index) in args" :key="index">
        <template v-if="arg.optional">?</template>
        <template v-if="!isRest(arg.type)">
          <span class="param-name">{{ arg.name }}</span>: <TypeRef :type="arg.type" />
        </template>
        <template v-else>
          <span class="param-name">...{{ arg.name }}</span>: <TypeRef :type="arg.type.typeParams[0]" />
        </template>
        <template v-if="arg.defaultValue"> = {{ arg.defaultValue }}</template>
        <span v-if="index !== args.length - 1">, </span>
      </span>)</span>:
      <span class="return-type" v-if="returnType"><TypeRef :type="returnType" /></span></span>
      <slot></slot>
    </span>
    <slot name="post"></slot>
  </span>
</template>

<style scoped lang="scss">
  .code {
    font-family: var(--vp-font-family-mono);
  }
  .everything-but-name {
    color: var(--vp-c-text-1);
  }
  .param-name {
    font-style: italic;
  }
</style>

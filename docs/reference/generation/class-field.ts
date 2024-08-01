import { Documentible } from "./documentible";
import { Meta } from "./meta";
import { Type } from "./type";

export enum RuntimeRights {
  Normal,
  No,
  Method,
  Dynamic,
  Inline,
}

export class ClassField implements Documentible {
  name: string;
  type: Type;
  typeParams: string[];
  meta: Meta[];
  readAccess: RuntimeRights;
  writeAccess: RuntimeRights;
  overloads: ClassField[] | null;
  isPublic: boolean;
  isOverride: boolean;
  isFinal: boolean;
  sourceLine?: number;
  documentation?: string;
}

export class ClassProperty extends ClassField { }

export class ClassMethod extends ClassField { }

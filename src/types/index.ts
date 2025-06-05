import type { CustomTag } from "@/contants";

export interface Article {
    tag: CustomTag[]
    description: string
    publishDate: string
    mdPath: string
    wordCount: number
    title: string
    id: string
    imageUrl: string
}

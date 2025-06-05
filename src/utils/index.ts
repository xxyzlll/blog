export function randomImgUrl(count: number): string {
    const cnt = getRandomInt(count)
    console.log('cnt',cnt)
    return `https://api.maho.cc/random-img/pc.php?${ cnt }`
}

export function getRandomInt(max: number, min = 0) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

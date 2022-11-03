//out/global/global.js
provideReferences(document, position) {
    const symbol = document.getText(document.getWordRangeAtPosition(position));
    const rlines = this.executeOnDocument(['--encode-path', '" "', '-xra', symbol], document);
    const lines = this.executeOnDocument(['--encode-path', '" "', '-xsa', symbol], document);
    const ret = mapNoneEmpty(rlines, line => XRef.parseLine(line).location);
    if (ret.length)
        return ret;
    return mapNoneEmpty(lines, line => XRef.parseLine(line).location);
}
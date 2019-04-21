const IPFS = require('ipfs-api')
const ipfs = new IPFS({ host: 'ipfs.infuro.io', port: 5001, protocol: 'https' });

export default ipfs;

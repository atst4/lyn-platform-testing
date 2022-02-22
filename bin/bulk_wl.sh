declare -a ADRESSES=(
    "erd1qyu5wthldzr8wx5c9ucg8kjagg0jfs53s8nr3zpz3hypefsdd8ssycr6th"
    "erd1spyavw0956vq68xj8y4tenjpq2wd5a9p2c6j8gsz7ztyrnpxrruqzu66jx"
    "erd1dc3yzxxeq69wvf583gw0h67td226gu2ahpk3k50qdgzzym8npltq7ndgha"
    # "erd1k2s324ww2g0yj38qn2ch2jwctdy8mnfxep94q9arncc6xecg3xaq6mjse8"
    # "erd18tudnj2z8vjh0339yu3vrkgzz2jpz8mjq0uhgnmklnap6z33qqeszq2yn4"
    # "erd1kyaqzaprcdnv4luvanah0gfxzzsnpaygsy6pytrexll2urtd05ts9vegu7"
    # "erd1r69gk66fmedhhcg24g2c5kn2f2a5k4kvpr6jfw67dn2lyydd8cfswy6ede"
    # "erd13x29rvmp4qlgn4emgztd8jgvyzdj0p6vn37tqxas3v9mfhq4dy7shalqrx"
    # "erd1fggp5ru0jhcjrp5rjqyqrnvhr3sz3v2e0fm3ktknvlg7mcyan54qzccnan"
    # "erd1kdl46yctawygtwg2k462307dmz2v55c605737dp3zkxh04sct7asqylhyv"
    # "erd1z32fx8l6wk9tx4j555sxk28fm0clhr0cl88dpyam9zr7kw0hu7hsx2j524"
    # "erd1uv40ahysflse896x4ktnh6ecx43u7cmy9wnxnvcyp7deg299a4sq6vaywa"
)
# myVarArgsEndpoint@0000000c_544f4b454e2d313233343536_0000000000000005_00000001_64_0000000c_544f4b454e2d313233343536_000000000000000a_00000002_01f4
SC_ADDRESS="erd1qqqqqqqqqqqqqpgqrjv97sjq5thmveexdwnlr8yfnkh62y9jjg9q402evd"
FIRST=true
PAYLOAD=""
OWNER_PEM="wallets/owner/owner.pem"
PROXY="https://devnet-gateway.elrond.com"
CHAIN="D"
bulkTx() {
    for ad in "${ADRESSES[@]}"; do
        hex=0x$(erdpy wallet bech32 --decode ${ad})
        if ($first); then
            PAYLOAD+=${hex}
            first=false
        else
            PAYLOAD+="_"${hex}
        fi
    done
    erdpy --verbose contract call ${SC_ADDRESS} \
        --recall-nonce \
        --pem=${OWNER_PEM} \
        --gas-limit=6000000 \
        --function whiteListMany \
        --arguments 0x${PAYLOAD} \
        --send \
        --proxy=${PROXY} \
        --chain=${CHAIN}
    
}

bulkTx

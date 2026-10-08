# Rewrites every remembered monitor setup in kwinoutputconfig.json so the
# physical order and the primary screen never depend on which monitors
# happen to be connected. Arguments: $order (left-to-right connectors),
# $primary (connectors in primary-first order), $width (logical px).
(.[] | select(.name == "outputs") | .data | map(.connectorName)) as $names
| (.[] | select(.name == "setups")).data |= map(
    .outputs as $outputs
    | ($outputs | map($names[.outputIndex])) as $present
    | ($order | map(select(. as $c | $present | index($c)))) as $row
    | ($primary | map(select(. as $c | $present | index($c)))) as $rank
    | .outputs |= map(
        $names[.outputIndex] as $name
        | .position = {x: (($row | index($name)) * $width), y: 0}
        | .priority = (($rank | index($name)) + 1)
    )
)

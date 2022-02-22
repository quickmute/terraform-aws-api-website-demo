exports.handler = (event, context, callback) => {
    const requestBody = JSON.parse(event.body);
    const argument = requestBody.argument;
    const square = argument * argument;
    const answer = `${argument}^2 = ${square}`;
    console.log(answer);
    callback(null, {
        statusCode:201,
        body: JSON.stringify({
            Response: answer,
        }),
        headers: {
            'Access-Control-Allow-Origin': '*',
        },
    });
};

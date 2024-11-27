import 'package:flutter/material.dart';


class Categories extends StatelessWidget {
  const Categories({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
            },
          ),
        ],
        backgroundColor: const Color(0xFF04130C),
      ),
      backgroundColor: const Color(0xFF03130B),
      body: SingleChildScrollView(child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1,
            color: Color(0xFF068441),
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Romantic",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        
                        
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image(
                                image: NetworkImage(
                                  "https://s3-alpha-sig.figma.com/img/f65c/59db/abfa774fe2d358ecf27d3ec41eba2c37?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=q6P0dwWteNwF-hbC64tE2RAL14pp5Dc~2qCHpEAehWymQDQ92T16WhRnWmqppZIjSjEDPWF8FCsaSiCkHWvf3lOXOiEMz9V0XbSy3SUlaQaJ9kwvJYQtAAFPBjnlVKl17qc6ubBgrFsPnbQAjUMAmb5wu41PTih1~1uv1tz4gX-QocvCXTWWXV1dv2QAHpwCjlxV1LSGhyOK5kn9tFcfwsemSVatLpEBRG-btl2v9ARAHcL0iO9MeSDRuHYcfYW31WyKo601XUTeIupho~LrHr7r0OZcc~d9eCkQbhzAp6pCE2U2-ZU2zutShxFMpZxRzz-HHZJNisaZgWMvq-vBSw__",
                                ),
                                width: 160,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Aashiqui 2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "(2013)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0), 
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/172a/92ed/3be14726adf70a00aa7f07b02704e194?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZclmZmM0T9KeBsK0JaPuQ-FIHOdD8sw7XaOF9Z20WWvmf8xZ7dPHs5gYBGLN8p0H0LpFLhwyBr~YSpbm6WvMg6mo5PwQ-tw7R8~pAdfC-DXqJXSE-iRtms7Dn6BhDi5o4IQpnWLH9C6qVuRndet4w4u36Q2qqr9G2PQkdX0NdIbBVEWelv42cI7g1niKPAPuqBT8TQvE6fTk4SWEAMUVd4VVoYc~QXLEqlBncZV8T9~lRzZb0zPLcrXDA1lAfDg~VGDGPka0ltOZDQ3w2abt-YxATdmcOz9YI5L0FyOOVMlHsz9LuU6W9D7fTM-oI5T~2EgaGXb3zfkOBJabo6gonQ__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Student of the year",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2012)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/7594/92d3/378c6086e96cde65d48b747e37ee674d?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XArlfTxjaSNchVJZMrSYfjIzss0RaUcfQRNOlNQ4yMD8t0rHM9PJd2k1HKn1JZ4-WpdxQY4SodhI7oVm8plqxtJQb~BDSszAeU18jRr~wE5YDxoIRBwWb5NVyn0SFOM8eCl5tkcTha4iWE8v0GrDxk-93TQES5tXw2cBABZCxIpOQMN3GEmaz02pKh12AHTtOtZnd6JM0Y~yQXvQIIE9lQXn7EYfAydVNCupWtfN47sIFQIoCDjNCg4SyZDYOO4-egLVm2wdCsibxy8u9iZMEClFsZQ9z7DyMqPk65xrJSE7hBqeAeL232PoaS5~5pAXHS~unLz3hLArEl5SHOjVpQ__",
                      ),
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Sanam Teri Kasam",
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(2016)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                  )
                ],
              ),
                ]
            ),
          ),
          ),
      
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Action",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/3efc/3ddc/4b79cdad661d6ec2c8351fc82b38b121?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=C72zeFWeNaI9jbzlYiOCEwxzWHVBkAQkam1qJ-oE8oY6Wq93dNUQ9ImwX0wsLEmhxvZMTw-3QYbKHxzhsqOjTjq6K3DqOA4X-xfa9iu~YrwJVUJe~d8Ri7q~JqBaeBuppuXLVFhyroCQJv1yHwwHC~ZtioT7mNEAWbv5dYIQ8o2ECoxu8HmH8qWvHPjE45uPFeaBP3dYwqHc6X50n5KMOzBMOXrW6JW4WTpO~jCIWHNKSgt2ssA~rUSmIetZcGKB0zP6tC8FEySCOVqJnTL9NI0uKOt7txK6jAXQewMFS2QkKDer9ZEjUhYLGQtkZx2bkAswVKp80Ujdd1GmHxDTRQ__",
                         ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Holiday",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2014)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0), 
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/05b8/70bc/8cce8198133932106f37b8186ff35435?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jTbZcfzihO5GBkRP6vaUIeSjtb-N9FYej~un13PI1oZJYUhzTZJofa-3C94e0i9jW5AUSjQo2mCNtqH6bzhSx~gvcElY7Zlqzc-tPRx0EYuvjOCvoO2QpAo2qmPRHqire~g3qT4xH-rtXb7quDjxNpiyeTd02W-DBlplMJDpCM~uGD0sCrHZQMjr~b9VCLnkBc-n-vEfPxC~DVhd7GfKd-5oSXx-fyO~-D9zhcbea4FVvzKGQAS-5gK9Jr0v4xG8niaC-DbOtrVvtef0QL7XqjkFFMeXqs0m4NFg5eQIZT31oekGBHlVhPunGykYJZeCpH~mCI-PYjhRbQF2kA6Tqg__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Pushpa",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2021)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/32b9/f0f0/7f61fd092835dacc96eb2b6b0e24342a?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Gjhj1uKqYf7xZ~lmKx86PPwhFWcflnUybLYJPbUzMyuvV2Xu91tIpXDqZy39A-9aShJRHuJ0PD1SWyFsvI3NTH5cWkBWYAl4tYboinv5AgXDn78OvbXxdWXdxN992A94b4SrgyUjSiUUoYu1sV98X3-ZZHdZTwcMdCmh1Th78hnN5wfCLlmtxXHi1HBMe6cAp9iF0r8Or190yv2UvbB8RZfmuGzxysfCPG3WSerDD5y4v1b9fwB5E704tBKgo4wCANerfL0XtZM9lE29UxhdTaem6VyjugdjXYuYrT2QR80Mil5SO~rP229yMgbp1UBVpIcOoGY5rwIrSrw6gMDRFg__",
                      ),
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Uri",
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(2019)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                  )
                ],
              ),
                ]
            ),
          ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thriller",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/32b9/f0f0/7f61fd092835dacc96eb2b6b0e24342a?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Gjhj1uKqYf7xZ~lmKx86PPwhFWcflnUybLYJPbUzMyuvV2Xu91tIpXDqZy39A-9aShJRHuJ0PD1SWyFsvI3NTH5cWkBWYAl4tYboinv5AgXDn78OvbXxdWXdxN992A94b4SrgyUjSiUUoYu1sV98X3-ZZHdZTwcMdCmh1Th78hnN5wfCLlmtxXHi1HBMe6cAp9iF0r8Or190yv2UvbB8RZfmuGzxysfCPG3WSerDD5y4v1b9fwB5E704tBKgo4wCANerfL0XtZM9lE29UxhdTaem6VyjugdjXYuYrT2QR80Mil5SO~rP229yMgbp1UBVpIcOoGY5rwIrSrw6gMDRFg__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Uri",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2019)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Padding(
                     padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/b093/346a/bf4b16cde4d6c305e9b6f5af06d538a2?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=FFT9CzgVcUZdWBwpveP246SnskIwlpn5L0GAioV5PVhe7y0Mn21rdoHnufcBkIbSpZR7dEsIAKwGSqZcJcUtsHbT7ibETKCLV2erKvJjnjIPfa081E7LlWclWY-B2jwvW~EJpgNto9cHlShB9jlyKzqU36X9oQuXiVwTHc37GKXSlOIKi9m~PcIVU-dsQTKmQhAPyWJOyQqDpRSXem9ZsIJsv3Z3lJJaHmw1KQ80QjiQ~DQvspQhreGQumqH1PPRT7icU1tOOgjvek~owro97AAOgs26tv8wvWJM2STGsmI~T-F-jiYmnw6wM5y~mkywOYty6IrCuyd04A3wnqJ3rg__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Contagion",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2011)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/86c4/ba64/da03b0425211412be7fc79fde72a5e99?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=I~giBD6S~rYkZyKfAW32buMCZC2334qWoXhv0v0y2oYj7tcIpRR-vDoLYV~5jJtlxLWoomLQ9ETAnNRJAwLp~WMPky~HAcH9ubQ63zhRFq5euCyUaU9Lvw8n9Y0gbOR2lAc-4zTeIIT5TKUPUVMcJtuPtM3UqlEdXR43YabHDGQM79gaTn74FaYBR4xrgoqcfwHyOGvoGYzIPIF58uqL9p4Evp7vfUbCrhunUP--xfZ0sQEFthZeQjDcg7jI-fUSZAUkd31TYLp1hpqMFsu5g01iMTtyaVhAAu8KSFyFPCXr-arUjWFai-p8ujLuWQk7xsfZ3A6QF3YPRjHgpt8eZA__",
                      ),
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "War of the Worlds",
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(2019)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                  )
                ],
              ),
                ]
            ),
          ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sci-fi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                     padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/7aa2/fab0/eafd3d240dc8ae282d094d30959a4a9d?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mQkGL9iQUsiEI2axNJzzxIl40qnBAxcsVJRIyxqW49B~eZc8htwuUDVX9VyRjzhOljzQVK5I5wiQV-ZkhvtvCtMiDE0yAhK3ERHrPEXQlCBDLzgwMvUFkbTNTKfbrRZHIpEalNCTFihPpRR46hg50xf6uxZ4oSsWgfXVvvji~MIp~OP2LYVc5sHBBFSfJ~qf20ciu94x4snHJkjRHAZ9YyjEo9OJUPKh1AF5jQMWPH9becTBAtGlYSu~I3AlZ0FfgTf6aS~tokOY5h9tTCUO1IMi9TF-zgOZXMA6G3vpsnMmWokdJJKdlS7ziUu4ilm8XBqIrOTevhfMzL6fUxnxrQ__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Dune",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2021)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Padding(
                     padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/3299/b685/5a7e97df57b44a20d3cf87b84b226467?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=fpxIyVHnXgu7EP5Cgl~TLEP1Bet5NdA2jEM7QQAxOw-PnvezeMTE0bd5NgVAnRf0fxrf13kENozQmU7amdmiPy6NCeWsGUEMr5NmYoBIZ-fMhPsVqJYyojYtLG8G58-dcWidQd49IkRMdNusFo2oZMeqfE-t-iGiSe1br5qvyNgkROg9oP~Lba1bTNk55cniQDkb6ZV9EozJDANscBaGoL6zZffxtH3u~DG~UhQAU3NKVmUYzRTICHS9~W996GdrYY7jupLfXiwVEGD61d67wXkTtkGa-TjTzqa-IheebP3S-cGkuX7erUtBc2BTF6LojQz47EUPG3yxcAClE~3mMQ__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Inception",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2010)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/d34f/d0fc/d304dc159f60cf6bc6d53d8be2e799c8?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NKVghhQ~EAJtHORLtMiDJpjHpLiOhh-rgsp5Zw5P3CXV-bdOMtfjM4Zc0Za65TsSdCgUXtPHPCxbdvfUaibWlk5de7o-zADg5vGg1UgjW3bE5ASamF9uTWMrTQvb9g07NUCacC0-Dc4ANZlKZolt0osiTnp33IqGbSdHZse2ZfuW2qV5lLpLZTIXmtpim9Os3e6xpds3jF4NykixwLXF7ioZELljTO3LlJg7YuQbLNxJOGgESuI0sCJ9upwqRGkBUq2HEYBWYg9yToNg0xhribOU0v~uVdD3wVsErl~9ulHVkkQiGxAFpQtl0f2iPenwHEAc5Unl44iveIBZe~PNNQ__",
                      ),
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "InterStelar",
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(2014)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                  )
                ],
              ),
                ]
            ),
          ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Horror",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/8391/2b73/70184ecb8603c3519cc15da2bd2c96ad?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Xkrwbn-aFY6PNiCMFut2PsyEKYVRUgm6A603GgHmgiZ1o-n0DW5jd7eX9jLpFVdXZ0CcfXsG5J6PEnkvv9x8gxtr3D9e5BGI-~49Mv1tJAoloAy5f~aJIcf2SlX~opF23ykvhSaD8qXxzp3ivmu~D-l5poHEVNNj5ScMmNXQtZFeaDux~BnFXdoodKrYjkaXd9a3eJ3OwO5azCS3V3fTk-xWeJP0i7bqvolsEj6ipLIpcSA3M9h0JmBwCS6WjQlAErDDIxznS6NZ72z0-UEbWAK-V4uvJy~O04aPWI3FTmFpggm7xbi3FtqniCo-eNauSuKsxLm~f2INLRP9bm1~2A__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Insidious",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2023)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/3d2d/f02e/592e58f3e380ec7c9fe131dcf6730389?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hlEj3T~EE7fTy9jWWqb5uCKVwEpzoEE7qXW2hrkEjeHrfnCRE5cP7TErQQrMB7Z3dkDDrTIAT5FX2sc8bj30p4V~GmBExHH5yw5daM-cW4wLNMeC0pEcDlNXTWQPfLYa0jvr1DPJJ-CoTi0kSqq5k8QRNtzkXHXn765t4T~HCugy7JsT~sZCXhWhhdfzlDeD1eAvcA6URXgeCuz1rgWbb38h1xUNmO1Y9M7EKu8a5Ep5BduSCw0r56dZis5oBxYHRyIWrxzSDRydK28fdKjkAxBSD~kaMesoaujmKHBgPSulJ5dWy0UXSXrkzVRb6DHxnGnWNoZX3JHsIucwshXmcA__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "The Exorcist",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(1973)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/623a/a39f/f30c4034470dc82775f653f25d18127a?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=TdoZXTU1lHLmpz0YlsEP1e0lNPlUCNUOYcsI-mfQzf8haWp30C1bXAuiR9z4yWtoOMOV4TvEUajdGEFeMgQ7olH5ElNoot1XEKSwOBPA2V4EBHs7yqoUZcYnz0fJW~P0zr99Hxvx1kH8dyWXsGhclxa99bNmObLiUTSGDxmmGbSByZ4ZMhG26F2wG5vm9ddSqeYOZZ23bFuADcgUYHr4fKYU5geGLkVhaDabAtQzuIolMF6Lbs3jXBmCGzPdRwIViq0tLiD~y~LpyAsHzErwG8Lc~8rCRg2TXCFyUQHKHY4HGNglWSWneGbJabEOVhmu6MPU12iR5ZkWBEGQqdzO4Q__",
                      ),
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "The Conjuring",
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(2013)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                  )
                ],
              ),
                ]
            ),
          ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Drama",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0), 
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/f65c/59db/abfa774fe2d358ecf27d3ec41eba2c37?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=q6P0dwWteNwF-hbC64tE2RAL14pp5Dc~2qCHpEAehWymQDQ92T16WhRnWmqppZIjSjEDPWF8FCsaSiCkHWvf3lOXOiEMz9V0XbSy3SUlaQaJ9kwvJYQtAAFPBjnlVKl17qc6ubBgrFsPnbQAjUMAmb5wu41PTih1~1uv1tz4gX-QocvCXTWWXV1dv2QAHpwCjlxV1LSGhyOK5kn9tFcfwsemSVatLpEBRG-btl2v9ARAHcL0iO9MeSDRuHYcfYW31WyKo601XUTeIupho~LrHr7r0OZcc~d9eCkQbhzAp6pCE2U2-ZU2zutShxFMpZxRzz-HHZJNisaZgWMvq-vBSw__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Aashiqui 2",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2013)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Padding(
                     padding: EdgeInsets.only(right: 8.0),
                    child : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                     ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image(
                        image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/172a/92ed/3be14726adf70a00aa7f07b02704e194?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZclmZmM0T9KeBsK0JaPuQ-FIHOdD8sw7XaOF9Z20WWvmf8xZ7dPHs5gYBGLN8p0H0LpFLhwyBr~YSpbm6WvMg6mo5PwQ-tw7R8~pAdfC-DXqJXSE-iRtms7Dn6BhDi5o4IQpnWLH9C6qVuRndet4w4u36Q2qqr9G2PQkdX0NdIbBVEWelv42cI7g1niKPAPuqBT8TQvE6fTk4SWEAMUVd4VVoYc~QXLEqlBncZV8T9~lRzZb0zPLcrXDA1lAfDg~VGDGPka0ltOZDQ3w2abt-YxATdmcOz9YI5L0FyOOVMlHsz9LuU6W9D7fTM-oI5T~2EgaGXb3zfkOBJabo6gonQ__",
                        ),
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                     const SizedBox(height: 8.0),
                          Text(
                            "Student of the year",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "(2012)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/7594/92d3/378c6086e96cde65d48b747e37ee674d?Expires=1733097600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XArlfTxjaSNchVJZMrSYfjIzss0RaUcfQRNOlNQ4yMD8t0rHM9PJd2k1HKn1JZ4-WpdxQY4SodhI7oVm8plqxtJQb~BDSszAeU18jRr~wE5YDxoIRBwWb5NVyn0SFOM8eCl5tkcTha4iWE8v0GrDxk-93TQES5tXw2cBABZCxIpOQMN3GEmaz02pKh12AHTtOtZnd6JM0Y~yQXvQIIE9lQXn7EYfAydVNCupWtfN47sIFQIoCDjNCg4SyZDYOO4-egLVm2wdCsibxy8u9iZMEClFsZQ9z7DyMqPk65xrJSE7hBqeAeL232PoaS5~5pAXHS~unLz3hLArEl5SHOjVpQ__",
                      ),
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Sanam Teri Kasam",
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "(2016)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                  )
                ],
              ),
                ]
            ),
          ),
          ),
        ],
      ),
      ),
    );
  }
}
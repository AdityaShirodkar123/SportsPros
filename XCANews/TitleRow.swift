//
//  TitleRow.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import SwiftUI

struct TitleRow: View {
    var articleID : Int
    
    var urlArray = ["",
    "https://i0.wp.com/atrendhub.com/wp-content/uploads/2018/08/0-1-1.png?fit=1024%2C437&ssl=1", "https://phenommedia.net/wp-content/uploads/2021/01/hi-res-8a8f90b0d1260d899093fb43c207c4e5_crop_north-1280x640.jpg", "https://media.cnn.com/api/v1/images/stellar/prod/221113125625-01-buccaneers-seahawks-nfl-1113.jpg", "https://cdn.cnn.com/cnnnext/dam/assets/221113204250-ronaldo-accuses-manchester-united-of-betrayal-exlarge-tease.jpg", "https://vmrw8k5h.tinifycdn.com/news/wp-content/uploads/2022/11/Riccardo_Di_Domenico_1.jpg"]
    
    var nameArr = ["", "Breaking Down the Premier League's \"Big 6\"", "Why Karim Benzema Is The Greatest French Player Of All Time", "Tom Brady makes history as Tampa Bay Buccaneers win first-ever regular season game in Germany", "‘I feel betrayed’: Cristiano Ronaldo claims he is being forced out of Manchester United", "Riccardo Di Domenico Downs 23-Year-Old Record at Evansville"]
    
    var body: some View {
        var imageUrl = URL(string: self.urlArray[articleID])
        

        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(nameArr[articleID])
                    .font(.title2).bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(articleID: 1)
            .background(.clear)
    }
}
